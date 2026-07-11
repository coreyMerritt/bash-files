# Load all files in .bashrc.d
bashrcd_path="$HOME/.bashrc.d"
files="$(ls -A $bashrcd_path)"
for file in $files; do
  source "${bashrcd_path}/${file}"
done
