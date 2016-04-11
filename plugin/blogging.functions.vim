   "New blog post Rmarkdown
   function! NewPost(...)
      "where is the _posts folder located?
      let blog_base_folder = "~/github/imouzon.github.io/"

      "what is today's date
      let blogdate = strftime("%Y-%m-%d")

      "did a title get submitted
      if a:0 > 0
         let blogtitle = a:1
      else
         let blogtitle = "thoughts"
      end

      let blogloc = blog_base_folder."Rmarkdown/".blogdate."-".blogtitle.".rmd"

      "open the new blog post
      execute "sp " blogloc
   endfunction

   "make a new blog post quickly
   nmap <Leader>pp :call NewPost()<CR>

   "knit new blog post using R and knitr
   command! RmdKnit !r --no-save --no-restore -e "require(knitr); knit('%')"

   function! KnitMD(...)
      if a:0 > 0
         let post_folder = a:1
      else
         let post_folder = '~/github/imouzon.github.io/_posts/'
      end
      let knit_cmd = 'silent !r --no-save --no-restore -e "require(knitr); knit(\"%\")"'
      execute knit_cmd
      execute 'silent !mv %:t:r.md ~/github/imouzon.github.io/_posts/%:t:r.md'
      execute "echom(\'A new post has been created in the _posts directory\')"
   endfunction

   "mp for make post
   nnoremap <silent> <Leader>mkp :call KnitMD()<CR>
