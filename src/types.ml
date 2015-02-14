(** Common signatures. *)

module type Functor = sig
  type 'a t
  val map : ('a -> 'b) -> ('a t -> 'b t)
end

module type Applicative = sig
  include Functor
  val pure : 'a -> 'a t
  val ap : ('a -> 'b) t -> 'a t -> 'b t
end

module type Monad = sig
  include Applicative
  val join : 'a t t -> 'a t
  val bind : ('a -> 'b t) -> ('a t -> 'b t)
end

module type Comonad = sig
  include Functor
  val extract : 'a t -> 'a
  val extend : ('a t -> 'b) -> 'a t -> 'b t
end

module type Functor1 = sig
  type ('e, 'a) t
  val map : ('a -> 'b) -> (('e, 'a) t -> ('e, 'b) t)
end

module type Applicative1 = sig
  include Functor1
  val pure : 'a -> ('e, 'a) t
  val ap : ('e, 'a -> 'b) t -> ('e, 'a) t -> ('e, 'b) t
end

module type Monad1 = sig
  include Applicative1
  val join : ('e, ('e, 'a) t) t -> ('e, 'a) t
  val bind : ('a -> ('e, 'b) t) -> (('e, 'a) t -> ('e, 'b) t)
end

module type Comonad1 = sig
  include Functor1
  val extract : ('e, 'a) t -> 'a
  val extend : (('e, 'a) t -> 'b) -> ('e, 'a) t -> ('e, 'b) t
end

module type Profunctor = sig
  type ('a, 'b) t
  val dimap : ('a_ -> 'a) -> ('b -> 'b_) -> ('a, 'b) t -> ('a_, 'b_) t
  val lmap : ('a_ -> 'a) -> ('a, 'b) t -> ('a_, 'b) t
  val rmap : ('b -> 'b_) -> ('a, 'b) t -> ('a, 'b_) t
end

module type Category = sig
  type ('a, 'b) t
  val id : ('a, 'a) t
  val compose : ('a, 'x) t -> ('x, 'b) t -> ('a, 'b) t
end

module type Arrow = sig
  include Profunctor
  include Category with type ('a, 'b) t := ('a, 'b) t
  val arr : ('a -> 'b) -> ('a, 'b) t
end

module type Strong = sig
  include Profunctor
  val first  : ('a, 'b) t -> ('a * 'x, 'b * 'x) t
  val second : ('a, 'b) t -> ('x * 'a, 'x * 'b) t
end

module type ViewLeft = sig
  type 'a t
  val uncons : 'a t -> ('a * 'a t) option
  val cons : 'a -> 'a t -> 'a t
end

module type Semigroup = sig
  type t
  val mult : t -> t -> t
end

module type Monoid = sig
  include Semigroup
  val one : t
end

module type Foldable = sig
  type 'a t
  type m
  val crush : ('a -> m) -> ('a t -> m)
end

module type Traversable = sig
  type 'a t
  type 'a f
  val traverse : ('a -> 'b f) -> ('a t -> 'b t f)
end

module type Foldable1 = sig
  type ('e, 'a) t
  type m
  val crush : ('a -> m) -> (('e, 'a) t -> m)
end

module type Traversable1 = sig
  type ('e, 'a) t
  type 'a f
  val traverse : ('a -> 'b f) -> (('e, 'a) t -> ('e, 'b) t f)
end
