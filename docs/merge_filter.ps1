# Rebuild the filtered merge of the two upstream repositories.
#
#   .\MERGE_FILTER.ps1 -BailuSrc <path\to\bailu.clone> -ZqilinSrc <path\to\zqilin.clone> -Out <merged\dir>
#
# The rules replicate MERGE_NOTES.md section 3. Existing content of -Out is removed first.

param(
    [Parameter(Mandatory = $true)][string]$BailuSrc,
    [Parameter(Mandatory = $true)][string]$ZqilinSrc,
    [Parameter(Mandatory = $true)][string]$Out
)

$excludeDirs = @(
    '.git', '.runs', '.cache', '.Xil', '.gen', '.ip_user_files', '.sim', '.hw',
    'xsim.dir', '__pycache__', '.codegraph', 'node_modules', '.vscode',
    '.ipynb_checkpoints', 'work', '.metadata', '.analytics'
)
$excludeExt = @(
    '.dcp', '.bit', '.ltx', '.wdb', '.jou', '.log', '.tsv', '.raw', '.o', '.a',
    '.so', '.exe', '.dll', '.pyc', '.zip', '.tar', '.gz', '.rbt', '.bin', '.str',
    '.pb', '.sdb', '.reloc', '.mem', '.xpr', '.hdf', '.rslt', '.odb', '.def',
    '.spef', '.gds', '.vcd', '.fst', '.saif', '.cdb', '.ddc', '.swp', '.db',
    '.qdb', '.qpg', '.qtl', '.qor'
)
$excludeName = @('.DS_Store', 'Thumbs.db')
$maxBytes = 2MB
$bulkLimit = 50

function Copy-Filtered {
    param([string]$Src, [string]$Dst)

    $counts = @{}
    Get-ChildItem $Src -Recurse -Directory -Force -ErrorAction SilentlyContinue | ForEach-Object {
        $counts[$_.FullName] = (Get-ChildItem $_.FullName -File -Force -ErrorAction SilentlyContinue).Count
    }
    $counts[$Src] = (Get-ChildItem $Src -File -Force -ErrorAction SilentlyContinue).Count

    $kept = 0; $bytes = 0; $bulk = 0
    Get-ChildItem $Src -Recurse -File -Force -ErrorAction SilentlyContinue | ForEach-Object {
        $rel = $_.FullName.Substring($Src.Length).TrimStart('\')
        $parts = $rel -split '\\'
        $skip = $false
        for ($i = 0; $i -lt $parts.Count - 1; $i++) {
            if ($excludeDirs -contains $parts[$i]) { $skip = $true; break }
        }
        if ($skip) { return }
        if ($excludeName -contains $_.Name) { return }
        if ($excludeExt -contains $_.Extension.ToLower()) { return }
        if ($_.Length -ge $maxBytes) { return }
        if ($counts.ContainsKey($_.DirectoryName) -and $counts[$_.DirectoryName] -gt $bulkLimit) {
            $script:bulk++; return
        }
        $target = Join-Path $Dst $rel
        New-Item -ItemType Directory -Force (Split-Path $target -Parent) | Out-Null
        Copy-Item $_.FullName $target -Force
        $script:kept++; $script:bytes += $_.Length
    }
    return [pscustomobject]@{
        Files = $script:kept
        MB    = [math]::Round($script:bytes / 1MB, 1)
        Bulk  = $script:bulk
    }
}

if (Test-Path $Out) { Remove-Item $Out -Recurse -Force }
New-Item -ItemType Directory -Force $Out | Out-Null

$script:kept = 0; $script:bytes = 0; $script:bulk = 0
$r1 = Copy-Filtered -Src $BailuSrc  -Dst (Join-Path $Out 'bailu')
"bailu : $($r1.Files) files, $($r1.MB) MB (bulk-skipped $($r1.Bulk))"

$script:kept = 0; $script:bytes = 0; $script:bulk = 0
$r2 = Copy-Filtered -Src $ZqilinSrc -Dst (Join-Path $Out 'zqilin')
"zqilin: $($r2.Files) files, $($r2.MB) MB (bulk-skipped $($r2.Bulk))"

$total = Get-ChildItem $Out -Recurse -File | Measure-Object -Property Length -Sum
"total : $($total.Count) files, $([math]::Round($total.Sum / 1MB, 1)) MB"
