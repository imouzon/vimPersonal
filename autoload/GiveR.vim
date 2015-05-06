command! GiveRF !cp %:p ~/FORTRAN/subroutines/f/%:r.f; R CMD SHLIB ~/FORTRAN/subroutines/f/%:r.f; mv ~/fortran/subroutines/f/%:r.so ~/fortran/subroutines/so/%:r.so; cp ~/FORTRAN/subroutines/f/%:r.f ~/R/shlib/code/%:r.f; cp ~/FORTRAN/subroutines/so/%:r.so ~/R/shlib/so/%:r.so;
command! GiveRC !cp %:p ~/C/functions/C/%:r.c; R CMD SHLIB ~/C/functions/C/%:r.c; mv ~/C/functions/f/%:r.so ~/C/functions/so/%:r.so; cp ~/C/functions/f/%:r.c ~/R/shlib/C/%:r.c; cp ~/C/functions/so/%:r.so ~/R/shlib/so/%:r.so;

function! GiveRfiletype()
   let ft = expand("%:e")
   if ft == 'c'
      GiveRC
   elseif ft == "f" || ft == "for"
      GiveRF
   else
      echom "The filetype" ft "does not compile to R"
   endif
endfunction

command! GiveR call GiveRfiletype()
command! AddR !echo "dyn.load('~/R/shlib/so/%:r.so')" >> ~/R/shlib/C_FORTRAN.shlib.R; echo "pck.load[[1]]<-unique(c(pck.load[[1]],'%:r'))" >> ~/R/shlib/C_FORTRAN.shlib.R
