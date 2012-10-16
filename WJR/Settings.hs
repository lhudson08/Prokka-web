{-# LANGUAGE CPP #-}
module WJR.Settings
  where

import Yesod.Default.Util
import Data.Default (def)
import Text.Hamlet

-- import Default_Util
import Language.Haskell.TH.Syntax

#ifdef PRODUCTION
development = False
listenPort = 3000
approotSetting = "http://vicbioinformatics.com/prokka"
#else
development = True
listenPort = 3001
approotSetting = "http://dna.med.monash.edu.au:"++show listenPort
#endif

-- | Settings for 'widgetFile', such as which template languages to support and
-- default Hamlet settings.
widgetFileSettings :: WidgetFileSettings
widgetFileSettings = def
    { wfsHamletSettings = defaultHamletSettings
        { hamletNewlines = AlwaysNewlines
        }
    }

widgetFile :: String -> Q Exp
widgetFile = (if development then widgetFileReload
                             else widgetFileNoReload
             ) widgetFileSettings

