
module type Functor = sig
  type 'a t
  val map : ('a -> 'b) -> ('a t -> 'b t)
end

module type Applicative = sig
  include Functor
  val pure : 'a -> 'a t
  val ap : ('a -> 'b) t -> 'a t -> 'b t
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
