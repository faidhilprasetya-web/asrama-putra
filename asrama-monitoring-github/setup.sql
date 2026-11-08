-- Jalankan di Supabase: SQL Editor -> New query -> tempel semua -> Run
-- GANTI 'GANTI_KODE_INI' dengan kode akses bersama Anda.

create table if not exists config(id int primary key default 1, code text not null);
create table if not exists kv(key text primary key, value jsonb not null, updated_at timestamptz default now());
alter table config enable row level security;
alter table kv enable row level security;

insert into config(id, code) values (1, 'GANTI_KODE_INI')
on conflict (id) do update set code = excluded.code;

create or replace function kv_check(p_code text) returns void
language plpgsql security definer set search_path = public as $$
begin
  if not exists (select 1 from config where id = 1 and code = p_code) then
    raise exception 'forbidden';
  end if;
end $$;

create or replace function kv_list(p_code text) returns table(key text, value jsonb)
language plpgsql security definer set search_path = public as $$
begin
  perform kv_check(p_code);
  return query select k.key, k.value from kv k;
end $$;

create or replace function kv_batch(p_code text, p_items jsonb) returns void
language plpgsql security definer set search_path = public as $$
declare i jsonb;
begin
  perform kv_check(p_code);
  for i in select jsonb_array_elements(p_items) loop
    if i->'value' is null or jsonb_typeof(i->'value') = 'null' then
      delete from kv where key = i->>'key';
    else
      insert into kv(key, value) values (i->>'key', i->'value')
      on conflict (key) do update set value = excluded.value, updated_at = now();
    end if;
  end loop;
end $$;

revoke all on function kv_check(text) from public, anon, authenticated;
revoke all on function kv_list(text) from public;
revoke all on function kv_batch(text, jsonb) from public;
grant execute on function kv_list(text), kv_batch(text, jsonb) to anon, authenticated;
