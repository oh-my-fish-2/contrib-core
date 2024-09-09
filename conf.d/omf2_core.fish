if not type -q omf2 && type -q fisher
    fisher install oh-my-fish-2/omf2
end

# Support Fisher's plugin events
function _omf2_core_install --on-event omf2_core_install
    echo omf2 handle install oh-my-fish-2/core
end

function _omf2_core_update --on-event omf2_core_update
    echo omf2 handle update oh-my-fish-2/core
end

function _omf2_core_uninstall --on-event omf2_core_uninstall
    echo omf2 handle uninstall oh-my-fish-2/core
end
