
{-# OPTIONS  --confluence-check --sized-types --cubical #-}

open import Cubical.Foundations.Prelude
open import Cubical.Foundations.Structure
open import Cubical.Algebra.Monoid
open import Cubical.Algebra.CommMonoid
open import Cubical.HITs.SetQuotients

import MBree
open import SemiRing

module MDerivation {ℓ} (·monoid : CommMonoid ℓ) where

open MBree {_} {·monoid}
module CM = CommMonoidStr (snd ·monoid)
C = ⟨ ·monoid ⟩

module Derivation (mbd : MonoidBiDer ·monoid BSemiRing λ x → [ ` x ])  where

  δ' : Bree → Bree → Bree
  δ' ∅ z = ∅
  δ' (` x) ∅ = ∅
  δ' (` x) (` z) = {!!}
  δ' x@(` _) (ƛ z) = ƛ λ q → δ' x (z q)
  δ' x@(` _) (z ∪ z1) = δ' x z ∪ δ' x z1
  δ' x@(` _) (z · z1) = δ' x z · z1 ∪ z · δ' x z1
  δ' (ƛ x) z = ƛ λ q → δ' (x q) z
  δ' (x ∪ y) z = (δ' x z) ∪ δ' y z
  δ' (x · y) z = δ' x z · y ∪ x · δ' y z

  δᶜ' : Bree → Bree → Bree
  δᶜ' x y = {!!}

  -- δ' : Bree → Bree
  -- δ' ∅ = ∅
  -- δ' (` x) = cm x
  -- δ' (ƛ f) = ƛ λ z → δ' (f z)
  -- δ' (x ∪ y) = δ' x ∪ δ' y
  -- δ' (x · y) = (δ' x · y) ∪ (x · δ' y)

  -- δ : Bree / S → Bree / S
  -- δ a = rec squash/ (λ z → [ δ' z ]) (λ a b r → eq/ _ _ (l1 a b r)) a where
  --   l1 : (a b : Bree) → S a b → S (δ' a) (δ' b)
  --   l1 .(x ∪ y ∪ z) .((x ∪ y) ∪ z) (assoc x y z) = assoc _ _ _
  --   l1 .(b ∪ ∅) b (rid .b) = rid _
  --   l1 .(x ∪ y) .(y ∪ x) (comm x y) = comm _ _
  --   l1 .(_ ∪ c) .(_ ∪ c) (∪c c r) = ∪c _ (l1 _ _ r)
  --   l1 .(b ∪ b) b (idem .b) = idem _
  --   l1 .(x · y · z) .((x · y) · z) (assoc· x y z) = rel-trans l11 l12 where
  --     l11 : S (δ' x · y · z ∪ x · (δ' y · z ∪ y · δ' z)) (x · y · δ' z ∪ x · δ' y · z ∪ δ' x · y · z)
  --     l11 = rel-trans (comm _ _) (rel-trans (∪c _ (rel-trans (dist` _ _ _) (comm _ _))) (rel-sym (assoc _ _ _)))
  --     l12 : S (x · y · δ' z ∪ x · δ' y · z ∪ δ' x · y · z)
  --             ((δ' x · y ∪ x · δ' y) · z ∪ (x · y) · δ' z)
  --     l12 = rel-trans (∪c _ (assoc· _ _ _)) (rel-trans (comm _ _) (∪c _ (rel-trans (comm _ _)
  --           (rel-trans (rel-sym (rel-trans (dist` _ _ _) (rel-trans (∪c _ (rel-trans (comm· _ _) (rel-sym (assoc· _ _ _)))) (rel-trans (comm _ _) (rel-trans (∪c _ (rel-trans (comm· _ _) (rel-sym (assoc· _ _ _)))) (comm _ _)))))) (comm· _ _)))))
  --   l1 .(b · ` CM.ε ) b (rid· .b) = {!!}
  --   l1 .(_ · c) .(_ · c) (·c c r) = {!!}
  --   l1 .(x · y) .(y · x) (comm· x y) = {!!}
  --   l1 .(x · ∅) .∅ (def∅· x) = {!!}
  --   l1 .(` x · ` y) .(` (x CM.· y)) (def· x y) = {!!}
  --   l1 .(x · (ƛ y)) .(ƛ (λ q → x · y q)) (defƛ· x y) = {!!}
  --   l1 .(x · (y ∪ z)) .(x · y ∪ x · z) (dist` x y z) = {!!}
  --   l1 .(ƛ (λ c → x c ∪ y c)) .((ƛ x) ∪ (ƛ y)) (distƛ∪ x y) = {!!}
  --   l1 .(ƛ (λ c → x c · y c)) .((ƛ x) · (ƛ y)) (distƛ· x y) = {!!}
  --   l1 .(ƛ y) b (remƛ .b y x) = {!!}
  --   l1 .(ƛ _) .(ƛ _) (ƛS x) = {!!}
  --   l1 x y (rel-sym r) = rel-sym (l1 _ _ r)
  --   l1 x z (rel-trans r1 r2) = rel-trans (l1 _ _ r1) (l1 _ _ r2)
