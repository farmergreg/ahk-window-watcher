;
; Window Watcher By Greg Dietsche - 5/12/2015
;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Format of the file is one line per window to watch for:
; {Window Title To Watch For}{Tab}{AHK Keystrokes to send}
global g_WatchFile := "WindowWatcher.txt"

ReloadWatchList()
SetTimer,WindowWatcher,1000

;An infinite loop - otherwise AHK will exit because we've not setup any hotkeys!
Loop {
	Sleep, 99999
}

WindowWatcher:
For i, val in g_WatchList {
	StringSplit, temp, val, %A_Tab%
	IfWinActive, %temp1%
	{
		SetTimer, WindowWatcher, Off
		Send,%temp2%
		WinWaitClose,,,60
		SetTimer,WindowWatcher,1000
	}
}
return

ReloadWatchList() {
	global g_WatchList := {}
	Loop, Read, %g_WatchFile%
	{
		g_WatchList.insert(A_LoopReadLine)
	}
}
