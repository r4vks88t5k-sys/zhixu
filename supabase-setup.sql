-- 知序 Supabase 初始化脚本
-- 运行前：在 Authentication -> Users 中创建管理员用户，复制其 UUID。
-- 将下面 YOUR-USER-UUID 替换成真实 UUID，再运行整份脚本。
create extension if not exists pgcrypto;

create table if not exists public.articles (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title text not null,
  summary text not null default '',
  content text not null default '',
  category text not null default '未分类',
  tags text[] not null default '{}',
  status text not null default 'draft' check (status in ('draft','published')),
  user_id uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  published_at timestamptz
);

create index if not exists articles_status_published_at_idx
  on public.articles(status, published_at desc);
create index if not exists articles_user_id_idx on public.articles(user_id);
alter table public.articles enable row level security;

-- 删除本项目同名旧策略，便于重复运行本脚本。
drop policy if exists "Public can read published articles" on public.articles;
drop policy if exists "Owner can read all articles" on public.articles;
drop policy if exists "Owner can create articles" on public.articles;
drop policy if exists "Owner can update articles" on public.articles;
drop policy if exists "Owner can delete articles" on public.articles;

create policy "Public can read published articles"
on public.articles for select to anon, authenticated
using (status = 'published');

create policy "Owner can read all articles"
on public.articles for select to authenticated
using (auth.uid() = '97f47413-d9bc-4cb6-8600-853b1fe83cec'::uuid);

create policy "Owner can create articles"
on public.articles for insert to authenticated
with check (auth.uid() = '97f47413-d9bc-4cb6-8600-853b1fe83cec'::uuid and user_id = auth.uid());

create policy "Owner can update articles"
on public.articles for update to authenticated
using (auth.uid() = '97f47413-d9bc-4cb6-8600-853b1fe83cec'::uuid)
with check (auth.uid() = '97f47413-d9bc-4cb6-8600-853b1fe83cec'::uuid and user_id = auth.uid());

create policy "Owner can delete articles"
on public.articles for delete to authenticated
using (auth.uid() = '97f47413-d9bc-4cb6-8600-853b1fe83cec'::uuid);

grant select on public.articles to anon, authenticated;
grant insert, update, delete on public.articles to authenticated;
