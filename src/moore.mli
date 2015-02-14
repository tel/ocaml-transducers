
type ('a, 'b, 's) spec =
  { step : 'a -> 's -> 's
  ; this : 's
  ; proj : 's -> 'b
  }

type ('a, 'b) t

val make : ('a, 'b, 's) spec -> ('a, 'b) t
val run  : ('a, 'b) t -> ('a -> ('b * ('a, 'b) t))

include Types.Profunctor   with type ('a, 'b) t := ('a, 'b) t
include Types.Functor1     with type ('a, 'b) t := ('a, 'b) t
include Types.Applicative1 with type ('a, 'b) t := ('a, 'b) t
include Types.Comonad1     with type ('a, 'b) t := ('a, 'b) t
