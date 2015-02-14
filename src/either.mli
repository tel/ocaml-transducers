(** A natural sum type with many operations.

    [Either] is a sum type, [('a, 'b) Either.t] is either ['a] or ['b]
    and we are able to determine at run time which is which.

*)

type ('a, 'b) t =
  | Inl of 'a
  | Inr of 'b

(** {1 Introduction } *)

val left  : 'a -> ('a, 'b) t
val right : 'b -> ('a, 'b) t

(** {1 Elimination } *)

val fold : ('a -> 'r) -> ('b -> 'r) -> (('a, 'b) t -> 'r)

(** {1 Transformation } *)

val bimap : ('a -> 'a_) -> ('b -> 'b_) -> ('a, 'b) t -> ('a_, 'b_) t

(** {1 Includes} *)

include Types.Functor1     with type ('a, 'b) t := ('a, 'b) t

(** The [Std] module includes a standard implementation of
    [Applicative] and [Monad] functionality. *)
module Std : sig
  include Types.Applicative1 with type ('a, 'b) t := ('a, 'b) t
  include Types.Monad1       with type ('a, 'b) t := ('a, 'b) t
end

(** The [Collect] module includes "purely applicative" functionality
    built around a particular [Monoid]. *)
module Collect (M : Types.Semigroup) : sig
  type 'a collect = (M.t, 'a) t
  include Types.Applicative with type 'a t := 'a collect
end

module Foldable (M : Types.Monoid) : Types.Foldable1
  with type ('a, 'b) t := ('a, 'b) t
   and type m := M.t

module Traversable (F : Types.Applicative) : Types.Traversable1
  with type ('a, 'b) t := ('a, 'b) t
   and type 'a f := 'a F.t
