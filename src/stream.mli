(** Lazy, functional, infinite streams

    Streams are infinite sequential containers. Each subsequent item
    is accessed by forcing the tail.

*)

type 'a t

(** {1 Introduction} *)

val unfold : ('a -> 'b * 'a) -> 'a -> 'b t
val pure : 'a -> 'a t
val ints : int t
val iterate : ('a -> 'a) -> 'a -> 'a t
val tabulate : (int -> 'a) -> 'a t

(** {1 Elimination} *)
    
(** Lazy right fold. This will only produce values if the passed
    function is careful to only force the tail as needed. *)
val fold : ('a -> 'b lazy_t -> 'b) -> 'a t -> 'b
val head : 'a t -> 'a
val tail : 'a t -> 'a t
val at : int -> 'a t -> 'a
val take : int -> 'a t -> 'a list
val take_while : ('a -> bool) -> 'a t -> 'a list
val drop : int -> 'a t -> 'a t
val drop_while : ('a -> bool) -> 'a t -> 'a t Lazy.t
val filter : ('a -> bool) -> 'a t -> 'a t
val inits : 'a t -> 'a list t
val tails : 'a t -> 'a t t

(** {1 Merges} *)

val zip_with : ('a -> 'b -> 'c) -> 'a t -> 'b t -> 'c t
val unzip_with : ('a -> 'b * 'c) -> 'a t -> 'b t * 'c t

(** Acts as a semigroup product. *)
val interleave : 'a t -> 'a t -> 'a t

(** {1 Included signatures} *)
    
include Types.ViewLeft    with type 'a t := 'a t
include Types.Functor     with type 'a t := 'a t
include Types.Applicative with type 'a t := 'a t
include Types.Comonad     with type 'a t := 'a t
