# Support Fisher's plugin events

function _omf2
    if not type -q omf2
        functions -e omf2
        fisher install oh-my-fish-2/omf2
    end
    omf2 $argv
end

function _omf2_plugins_core_install --on-event omf2_plugins_core_install
    _omf2 install oh-my-fish-2/plugins-core
end

function _omf2_plugins_core_update --on-event omf2_plugins_core_update
    _omf2 update oh-my-fish-2/plugins-core
end

function _omf2_plugins_core_uninstall --on-event omf2_plugins_core_uninstall
    _omf2 uninstall oh-my-fish-2/plugins-core
end
