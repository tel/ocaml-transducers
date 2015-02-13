
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

module type ViewLeft = sig
  type 'a t
  val uncons : 'a t -> ('a * 'a t) option
  val cons : 'a -> 'a t -> 'a t
end
