import           Control.DeepSeq
import           Control.Parallel.Strategies

ls = [1..2]
fun = ((1 +) <$>) . Just

lss = map fun ls

-- calling it will result in :sprint lss => lss = _ : _
frc1 =
    let
        fr' :: [Maybe Int]
        fr' = lss
    in fr' `seq` "done"

-- calling it will result in :sprint lss => lss = [Just 2, Just 3]
frc2 =
    let
        fr' :: [Maybe Int]
        fr' = force lss
    in fr' `seq` "done"
--          ^^^
-- if no `seq` called on fr', result, as expcted, will be :sprint lss => lss = _
{--
repr - evalueates to WHNF
force - evaluates whole structure
--}
