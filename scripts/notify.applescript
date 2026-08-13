on run argv
	set projectName to "Claude Code"
	set notifMessage to "Turn finished"

	if (count of argv) > 0 then
		set projectName to item 1 of argv
	end if
	if (count of argv) > 1 then
		set notifMessage to item 2 of argv
	end if

	display notification notifMessage with title "Claude Code" subtitle projectName sound name "Glass"
end run
