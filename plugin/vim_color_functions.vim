"--------------------------------------**--------------------------------------"
"  File Name: vim_color_functions.vim
"  Purpose: Makes changing colors easier by setting my current preferred light
"           and dark themes called by using ColorMe(light) or ColorMe(dark)
"  Creation Date: 03-12-2014
"  Last Modified:
"  Created By:
"
"--------------------------------------**--------------------------------------"
"

function! ColorMe(...)
   if a:1 == 'light'
      :colorscheme summerfruit256
   endif
   if a:1 == 'dark'
      :colorscheme wombat
   endif
endfunction

command! Colordark call ColorMe('dark')
command! Colorlight call ColorMe('light')
      
"-- Light Themes
" autumn
" autumn2
" autumnleaf
" baycomb
" bclear
" biogoo
" breeze
" buttercream
" calmar256-light
" chela_light
" cleanphp
" codepaper
" dawn
" desert
" eclipse
" fine_blue2
" fog
" fruit
" google-prettify
" habilight
" impact
" ironman
" marklar
" martin_krischik
" mayansmoke
" navajo
" nuvola
" oceanlight
" oftblue
" papayawhip
" peaksea
" print_bw
" pyte
" satori
" sienna
" silent
" simpleandfriendly
" soso
" spring
" tabula
" taqua
" tcsoft
" tolerable
" vc
" vylight
" winter
" wood
" xemacs

"-- 256 Light Themes
" summerfruit256
" calmar256-light

"-- Colorful themes
" aqua
" astronaut
" borland
" robinhood
" sea

"-- Dark colorschemes
" adaryn
" adrian
" aiseered
" anotherdark
" asu1dark
" biogoo
" blacksea
" bluegreen
" brookstream
" calmar256-dark
" camo
" candy
" candycode
" chocolateliquor
" clarity
" colorer
" dante
" darkZ
" darkblue2
" darkbone
" darkburn
" darkslategray
" darkspectrum
" denim
" desert
" desert-warm
" desert256
" desertEx
" devbox-dark
" dusk
" dw_blue
" dw_cyan
" dw_green
" dw_orange
" dw_purple
" dw_red
" dw_yellow
" earendel
" ekvoli
" fnaqevan
" freya
" fruity
" fu
" gardener
" golden
" grayvim
" guardian
" gummybears
" herald
" inkpot
" jammy
" jellybeans
" jungle
" kellys
" leo
" lettuce
" lodestone
" manxome
" maroloccio
" matrix
" molokai
" moria
" moss
" motus
" mrkn
" mustang
" navajo-night
" neon
" neverness
" night
" nightshimmer
" no_quarter
" northland
" oceanblack
" oceandeep
" olive
" railscasts
" railscasts2
" rdark
" relaxedgreen
" rootwater
" settlemyer
" softblue
" sorcerer
" southernlights
" synic
" tango
" tango2
" tesla
" tir_black
" torte
" twilight
" two2tango
" underwater
" vibrantink
" vividchalk
" wombat256
" wombat256mod
" wuye
" xoria
" xoria256
" xoriam
" zenburn
" zmrok
