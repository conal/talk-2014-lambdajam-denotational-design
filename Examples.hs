{-# LANGUAGE GADTs, KindSignatures, TypeFamilies #-}
{-# LANGUAGE ConstraintKinds, FlexibleInstances #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wall #-}

-- {-# OPTIONS_GHC -fno-warn-unused-imports #-} -- TEMP
-- {-# OPTIONS_GHC -fno-warn-unused-binds   #-} -- TEMP

----------------------------------------------------------------------
-- | Examples for denotational design talk
----------------------------------------------------------------------

module Examples where

import Prelude hiding (id,(.))
import qualified Prelude as P
import GHC.Prim (Constraint)

{--------------------------------------------------------------------
    
--------------------------------------------------------------------}

class Yes1 a
instance Yes1 a

infixr 9 .

class Category k where
  type Obj k :: * -> Constraint
  type Obj k = Yes1
  id  :: Obj k a => k a a
  (.) :: (Obj k a, Obj k b, Obj k c) => k b c -> k a b -> k a c

instance Category (->) where
  id = P.id
  (.) = (P..)

{--------------------------------------------------------------------
    Meanings
--------------------------------------------------------------------}

class Meaningful a where
  type Meaning a
  meaning :: a -> Meaning a

{--------------------------------------------------------------------
    1D linear transformations
--------------------------------------------------------------------}
 
data Lin :: * -> * -> * where
  Scale :: Num a => a -> Lin a a

instance Meaningful (Lin a b) where
  type Meaning (Lin a b) = a -> b  -- really, _linear_ functions
  meaning (Scale s) = (s*)

instance Category Lin where
  type Obj Lin = Num
  id = Scale 1
  Scale s . Scale s' = Scale (s * s')

#if 0

-- Derivation

-- Spec: meaning id == id

  id
== \ x -> x
== \ x -> 1 * x
== meaning (Scale 1)

-- Spec: meaning (g . f) == meaning g . meaning f

  meaning (Scale s) . meaning (Scale s')
== (s *) . (s' *)
== ((s * s') *)
== meaning (Scale (s * s'))

#endif
