
type ('a, 'b, 's) spec =
  { step : 'a -> 's -> 's
  ; this : 's
  ; proj : 's -> 'b
  }

type ('a, 'b) t

val make : ('a, 'b, 's) spec -> ('a, 'b) t
val run  : ('a, 'b) t -> ('a -> ('b * ('a, 'b) t))
                        
val dimap : ('a_ -> 'a) -> ('b -> 'b_) -> ('a, 'b) t -> ('a_, 'b_) t
val lmap : ('a_ -> 'a) -> ('a, 'b) t -> ('a_, 'b) t
val rmap : ('b -> 'b_) -> ('a, 'b) t -> ('a, 'b_) t
val inject : ('a -> 'b) -> ('a, 'b) t
val pure : 'a -> ('e, 'a) t
val ap : ('e, 'a -> 'b) t -> ('e, 'a) t -> ('e, 'b) t
val extract : ('e, 'b) t -> 'b
val extend : (('e, 'a) t -> 'b) -> ('e, 'a) t -> ('e, 'b) t
