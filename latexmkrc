# From: https://www.nesono.com/?q=book/export/html/347
#
#

#$pdf_mode = 1;
#$pdf_previewer = 'osascript -e "set theFile to POSIX file \"%S\" as alias" -e "set thePath to POSIX path of theFile" -e "tell application \"Skim\"" -e "open theFile" -e "end tell"';
#$pdf_previewer = 'open -a skim'
# -pvc equivalent.  If nonzero, run a previewer to view the document and keep the DVI file up to date.
#$preview_continuous_mode = 1;
#%$pdf_update_method = 4;
#$pdf_update_command = '/usr/bin/osascript -e "set theFile to POSIX file \"%S\" as alias" -e "set thePath to POSIX path of theFile" -e "tell application \"Skim\"" -e  "  set theDocs to get documents whose path is thePath" -e "  try" -e "    if (count of theDocs) > 0 then revert theDocs" -e "  end try" -e "  open theFile" -e "end tell"';
$pdflatex = 'pdflatex --shell-escape %O %S';
#$pdflatex = 'pdflatex -synctex=1 %O %S';
#$latex = 'latex --shell-escape';
