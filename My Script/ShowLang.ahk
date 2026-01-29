#Persistent
#NoTrayIcon
#SingleInstance force
SetTimer, CheckLang, 100

prevLang := ""

CheckLang:
    lang := GetKeyboardLayout()
    if (lang != prevLang) {
        prevLang := lang
        ToolTip, %lang%
        SetTimer, HideTooltip, -1000
    }
Return

HideTooltip:
    ToolTip
Return

GetKeyboardLayout() {
    threadID := DllCall("GetWindowThreadProcessId", "UInt", WinActive("A"), "UInt", 0)
    layoutID := DllCall("GetKeyboardLayout", "UInt", threadID)
    langID := layoutID & 0xFFFF
    if (langID = 0x041E)
        return "TH"
    else if (langID = 0x0409)
        return "EN"
    else if (langID = 0x0411)
        return "JP"
    else
        return Format("{:X}", langID)
}
