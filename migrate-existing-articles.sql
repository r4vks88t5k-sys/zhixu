-- 可选：导入原 articles.json 中的示例文章。
-- 请先运行 supabase-setup.sql 并把 YOUR-USER-UUID 替换为管理员 UUID。
-- 如果不想导入示例文章，可跳过此文件；也可以通过编辑器重新创建。
insert into public.articles (slug,title,summary,content,category,tags,status,user_id,published_at) values
('welcome-to-zhixu','欢迎来到知序','这里是个人文章的整理空间。你可以记录学习过程、数学思考，也可以把偶然出现的灵感保存下来。','# 欢迎来到知序

这里是我的个人文章空间，用来整理思考、记录学习过程，也收集那些值得以后重新阅读的灵感。

## 为什么写作？

写下来，才能更清楚地看见自己的思路。一个问题从最初的疑惑，到尝试、修正，再到最终理解，这个过程本身就值得记录。

## 这里支持什么？

- 使用 **Markdown** 编写标题、列表、引用和代码。
- 使用 LaTeX 排版数学公式，例如行内公式 $a^2+b^2=c^2$。
- 使用独立公式展示推导：

$$
1+2+\cdots+n=\frac{n(n+1)}{2}
$$

> 好的笔记不只是保存结论，也保存抵达结论的过程。

## 继续探索

你可以返回首页浏览其他文章。未来，这里还会逐步加入分类、标签和云端发布等功能。','公告',array['知序','开始']::text[],'published','YOUR-USER-UUID'::uuid,'2026-10-13T00:00:00Z'::timestamptz),
('markdown-and-math','用 Markdown 记录数学','简单介绍如何在文章中组织标题、列表与公式，让数学笔记既清晰又容易维护。','# 用 Markdown 记录数学

Markdown 让我们专注于内容本身，而不用频繁调整排版。

## 一个简单的结构

1. 写清问题与已知条件。
2. 记录关键观察。
3. 给出推导过程。
4. 单独总结结论。

## 公式示例

行内公式可以写成 $f(x)=x^2$。

独立公式可以写成：

$$
\sum_{k=1}^{n}k=\frac{n(n+1)}{2}
$$

## 引用与代码

> 先说明每一步为什么成立，再整理证明会更可靠。

代码片段可以使用围栏：

```cpp
#include <iostream>
using namespace std;

int main(){
    cout << "Hello, Markdown!";
    return 0;
}
```

记录时尽量保留关键的思考过程，而不只是最终答案。','学习笔记',array['Markdown','LaTeX','数学']::text[],'published','YOUR-USER-UUID'::uuid,'2026-10-12T00:00:00Z'::timestamptz)
on conflict (slug) do nothing;
