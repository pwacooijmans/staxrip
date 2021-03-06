$msg = @"
This script does the following:

- Sets video to mux from source or previous encoding
- Sets audio to mux
- Sets MP4Box or mkvmerge as muxer

With MKV output you can cut/trim in the preview dialog.

Edit the script if you want this message to disappear.
"@

$td = new-object "TaskDialog[string]"
$td.MainInstruction = "Re-mux"
$td.Content = $msg
$td.AddButton("Continue", "c")
$td.AddButton("Abort" , "")
$result = $td.Show()
$td.Dispose()

if ($result -ne "c") {exit}

# active project
$p = [ShortcutModule]::p

#global object with miscelenius stuff
$g = [ShortcutModule]::g

$td = new-object "TaskDialog[string]"
$td.MainInstruction = "Select a muxer."
$td.AddCommandLink("MKV using mkvmerge", "mkv")
$td.AddCommandLink("MP4 using MP4Box" , "mp4")
$result = $td.Show()
$td.Dispose()

if ($result -eq "mkv") {
    $muxer = new-object "MkvMuxer"
} elseif ($result -eq "mp4") {
    $muxer = new-object "MP4Muxer"
} else {exit}

$nullVideoEncoder = New-Object "NullEncoder"
$g.LoadVideoEncoder($nullVideoEncoder)
$p.VideoEncoder.LoadMuxer($muxer)

$muxAudio0 = new-object "MuxAudioProfile"
$g.LoadAudioProfile0($muxAudio0)

$muxAudio1 = new-object "MuxAudioProfile"
$g.LoadAudioProfile1($muxAudio1)