""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Checker
" 
" Version: $Revision: 2.0 $
" Id     : $Id: spell.vim,v 1.9 2001/10/11 11:15:17 mveit Exp $
" Date   : September 2001
"
" Author : Matthias Veit <matthias_veit@yahoo.de>
"
" Improvements by: Patrik Sundberg <ps@radiac.mine.nu>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""

let s:language_tag = $LANG

function SpellCheck()
ruby << RUBYBLOCK
    #setup syntax highligting
    lang = VIM::evaluate("s:language_tag")
    VIM::command("syn match BADWORD \"BADWORD\"")
    VIM::command("syn clear BADWORD")
    VIM::command("highlight BADWORD term=bold ctermfg=Red guibg=Orange guifg=Black")
    buffer = VIM::Buffer.current
    aspell = IO.popen("aspell --language-tag=#{lang} -t -l", "w+") #--language-tag=de_DE 
    1.upto(buffer.count) { |linenr| 
      aspell.puts(buffer[linenr])
    }
    aspell.close_write
    aspell.each { |badword|
      badword.chomp!
      VIM::command("syn match BADWORD \"\\<#{badword}\\>\"")
    }
RUBYBLOCK
endfunction 

function Propose()
ruby << RUBYBLOCK
    lang = VIM::evaluate("s:language_tag")
    cword = VIM::evaluate("expand(\"<cword>\")")
    aspell = IO.popen("aspell --language-tag=#{lang} -a","w+")
    aspell.puts(cword)
    aspell.close_write
    aspell.readlines.each{ |line|
      if (line=~/^#/)
        print("Sorry, no proposals for #{cword}\n")
      elsif (line=~/^\*/)
        print("#{cword} is correct!\n")
      elsif (line=~/^&.*:\s*(.+)/)
        counter = 0 
        words = $1.split(/,\s*/)
        print("Proposal(s) for #{cword}\n")
        print("-------------------------------\n")
        words.each { |word|
          print("(#{counter+1}) #{word}\n")
          counter += 1
        }
        print("Change '#{cword}' to alternative (return for no change): ")
        alt = VIM::evaluate("input('[1-#{counter}] ')").chomp.to_i
        if (alt < counter+1) and (alt > 0)
            VIM::command("%s/#{cword}/#{words[alt-1]}/g")
        end
      end
    }
RUBYBLOCK
endfunction 

function AddToDictionary()
ruby << RUBYBLOCK
    langtag_to_dic = {
      "de_DE" => "de",
      "uk_UK" => "english",
      "us_US" => "english"
    }
    dic = langtag_to_dic[VIM::evaluate("s:language_tag")]
    raise "Which dictionary to use with language tag #{VIM::evaluate("s:language_tag")} ??" if (dic.nil?)
    privatedic = ENV["HOME"]+File::Separator+".aspell."+dic+".pws"
    cword = VIM::evaluate("expand(\"<cword>\")")
    content = nil
    if (File.exists?(privatedic))
      content = File.readlines(privatedic)
      header = content[0]
      header =~ /(\S+\s\S+\s)(\d+)/
      content[0]="#{$1}#{$2.to_i+1}\n"
    else
      content = ["personal_ws-1.1 #{dic} 1\n"]
    end
    content.push(cword+"\n")
    dictionary = File.open(privatedic,"w+")
    dictionary.write(content)
    dictionary.close
RUBYBLOCK
endfunction 

function! SpchkNxt()
    let badword   = synIDtrans(hlID("BADWORD"))
    let lastline= line("$")
    let curcol  = 0
    norm w
    while synIDtrans(synID(line("."),col("."),1)) != badword
      norm w
      if line(".") == lastline
        let prvcol=curcol
        let curcol=col(".")
        if curcol == prvcol
          break
        endif
      endif
    endwhile
    unlet curcol
    unlet badword
    unlet lastline
    if exists("prvcol")
      unlet prvcol
    endif
endfunction

function! SpchkPrv()
    let badword = synIDtrans(hlID("BADWORD"))
    let curcol= 0
    norm b
    while synIDtrans(synID(line("."),col("."),1)) != badword
      norm b
      if line(".") == 1
        let prvcol=curcol
        let curcol=col(".")
        if curcol == prvcol
          break
        endif
      endif
    endwhile
    unlet curcol
    unlet badword
    if exists("prvcol")
      unlet prvcol
    endif
endfunction

function SpellAutoEnable()
    augroup classbrowser
      autocmd! CursorHold * call SpellCheck()
      set updatetime=2000
    augroup END
endfunction

function SpellAutoDisable()
    augroup classbrowser
      syn clear BADWORD
      autocmd! CursorHold * 
      set updatetime=4000
    augroup END
endfunction

function SetLanguageTag(tag)
    let s:language_tag=a:tag
endfunction

nmap \p :call Propose()<cr>
nmap \c :call SpellCheck()<cr>
nmap \a :call AddToDictionary()<cr>


amenu 190.80.10 E&xtended.Spell.&check :call SpellCheck()<cr>
amenu 190.80.20 E&xtended.Spell.&clear :syn clear BADWORD<cr>
amenu 190.80.30 E&xtended.Spell.&proposal :call Propose()<cr>
amenu 190.80.40 E&xtended.Spell.&add\ word :call AddToDictionary()<cr>
amenu 190.80.50 E&xtended.Spell.&dictionary.&Deutsch :call SetLanguageTag("de_DE")<cr>
amenu 190.80.50 E&xtended.Spell.&dictionary.&English :call SetLanguageTag("us_US")<cr>
amenu 190.80.60 E&xtended.Spell.au&to.&enable :call SpellAutoEnable()<cr>
amenu 190.80.60 E&xtended.Spell.au&to.&disable :call SpellAutoDisable()<cr>

