
type ('a, 'b) t =
  | Inl of 'a
  | Inr of 'b

let left  a = Inl a
let right b = Inr b

(** {1 Elimination } *)

let fold f g = function
  | Inl a -> f a
  | Inr b -> g b
                                       

(** {1 Transformation } *)

let bimap f g = function
  | Inl a -> Inl (f a)
  | Inr b -> Inr (g b)

(* (\** {1 Includes} *\) *)

let map  f = bimap (fun x -> x) f

module Std = struct
  let map = map
  let pure a = Inr a
  let ap ef ea = match ef, ea with
    | Inr f, Inr a -> Inr (f a)
    | Inl e, _     -> Inl e
    | _    , Inl e -> Inl e
  let join = function
    | Inr x -> x
    | Inl e -> Inl e
  let bind f e = join (map f e)
end

module Collect (M : Types.Semigroup) = struct
  type 'a collect = (M.t, 'a) t
  let map = map
  let pure a = Inr a
  let ap ef ea = match ef, ea with
    | Inr f , Inr a  -> Inr (f a)
    | Inl e1, Inl e2 -> Inl (M.mult e1 e2)
    | Inl e , _      -> Inl e
    | _     , Inl e  -> Inl e
end

module Foldable (M : Types.Monoid) = struct
  let crush f = function
    | Inl e -> M.one
    | Inr a -> f a
end

module Traversable (F : Types.Applicative) = struct
  let traverse f = function
    | Inl e -> F.pure (Inl e)
    | Inr a -> F.ap (F.pure right) (f a)
end
