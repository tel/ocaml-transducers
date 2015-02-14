(** Transducers are transformers of streams which can be composed and
    then operated. *)

type ('a, 'b) t

(** {1 Combinators} *)

val flat_map : ('a -> 'b Stream.t) -> ('a, 'b) t
val keep : ('a -> 'b option) -> ('a, 'b) t
val filter : ('a -> bool) -> ('a, 'a) t
val take : int -> ('a, 'a) t

(** {1 Includes} *)

include Types.Functor1     with type ('a, 'b) t := ('a, 'b) t
include Types.Profunctor   with type ('a, 'b) t := ('a, 'b) t
include Types.Category     with type ('a, 'b) t := ('a, 'b) t
include Types.Arrow        with type ('a, 'b) t := ('a, 'b) t

