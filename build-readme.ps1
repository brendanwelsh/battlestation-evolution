# Regenerates README.md from images/.
# Add a photo: drop it in images/ named NN-YYYY.jpg (next number), then run:
#   powershell -ExecutionPolicy Bypass -File build-readme.ps1
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$imgDir = Join-Path $root 'images'
$imgs = Get-ChildItem $imgDir -File | Where-Object { $_.Extension -match '(?i)\.(jpe?g|png|gif|webp)$' } | Sort-Object Name
$nl = "`r`n"
$md = "# Evolution of my Battlestation " + [char]0xD83E + [char]0xDD88 + $nl + $nl
$md += "A running photo log of the chumthewaters battlestation, 2006 -> present. Oldest first." + $nl + $nl
$md += "> **Add a shot:** drop it in ``images/`` named ``NN-YYYY.jpg`` (next number), then run ``powershell -ExecutionPolicy Bypass -File build-readme.ps1``." + $nl + $nl + "---" + $nl + $nl
foreach ($f in $imgs) { $yr=""; if($f.BaseName -match '(\d{4})'){ $yr=$matches[1] }; $md += ("### " + $yr) + $nl + ("![" + $f.BaseName + "](images/" + $f.Name + ")") + $nl + $nl }
$md += "---" + $nl + ("_" + $imgs.Count + " shots and counting._") + $nl
Set-Content -Path (Join-Path $root 'README.md') -Value $md -Encoding UTF8
Write-Output ("README regenerated with " + $imgs.Count + " images")