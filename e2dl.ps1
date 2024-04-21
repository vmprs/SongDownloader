Add-Type -AssemblyName System.Windows.Forms

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Song Downloader"
$form.Size = New-Object System.Drawing.Size(400, 150)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Create controls
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(20, 20)
$label.Size = New-Object System.Drawing.Size(360, 20)
$label.Text = "Enter the URL of the song you want to download:"
$form.Controls.Add($label)

$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(20, 50)
$textbox.Size = New-Object System.Drawing.Size(360, 20)
$form.Controls.Add($textbox)

$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(150, 80)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "Download"
$form.Controls.Add($button)

# Add event handler for the button click
$button.Add_Click({
    $songUrl = $textbox.Text

    # Validate the URL format
    if (-not ($songUrl -match "^(http|https)://.*")) {
        [System.Windows.Forms.MessageBox]::Show("Error: Invalid URL format. Please enter a valid URL starting with 'http://' or 'https://'", "Error", "OK", "Error")
        return
    }

    # Set the output directory
    $outputDir = "$env:userprofile\Music\yt-dlp\Download"

    # Ensure the output directory exists
    if (-not (Test-Path -Path $outputDir -PathType Container)) {
        New-Item -Path $outputDir -ItemType Directory | Out-Null
    }

    # Download the song using yt-dlp
    $command = "yt-dlp --extract-audio --audio-format mp3 --output " + '"' + $outputDir + "\%(title)s.%(ext)s" + '"' + " " + $songUrl
    Invoke-Expression $command

if ($LASTEXITCODE -eq 0) {
    [System.Windows.Forms.MessageBox]::Show("Song downloaded successfully.", "Success", "OK", "Information")
} else {
    [System.Windows.Forms.MessageBox]::Show("Error: Failed to download the song.", "Error", "OK", "Error")
}
})

# Show the form
$form.ShowDialog() | Out-Null
