if not type -q omf2 && type -q fisher
    fisher install oh-my-fish-2/omf2
end

# Support Fisher's plugin events
function _omf2_core_install --on-event omf2_core_install
    omf2 fisher-event install oh-my-fish-2/contrib-core
end

function _omf2_core_update --on-event omf2_core_update
    omf2 fisher-event update oh-my-fish-2/contrib-core
end

function _omf2_core_uninstall --on-event omf2_core_uninstall
    omf2 fisher-event uninstall oh-my-fish-2/contrib-core
end
