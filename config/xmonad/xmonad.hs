import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Place

import Graphics.X11.ExtraTypes.XF86

import qualified Data.Map as M

main = xmonad =<< xmobar defaultConfig 
    { borderWidth        = 2
    , modMask = mod4Mask
    , keys = myKeys <+> keys defaultConfig 
    , mouseBindings = myMouseBindings <+> mouseBindings defaultConfig 
    , manageHook = myManageHook <+> manageHook defaultConfig
    , terminal           = myTerminal
    , normalBorderColor  = "#cccccc"
    , focusedBorderColor = "#cd8b00" }

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $ 
    [ ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +1.5%")
    , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -1.5%")
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle")
    , ((0, xF86XK_AudioMicMute), spawn "pactl set-source-mute 1 toggle")
    ]

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask, button4), \_ -> nextWS)
    , ((modMask, button5), \_ -> prevWS)
    ]

myTerminal = "urxvt"

myManageHook = composeAll 
    [ resource =? "gmrun" --> doCenterFloat 
    ]

myPlacement = inBounds $ fixed (0.5, 0.5)
