
(* type ('a, 'b) t = { t : 'r . ('b, 'r) Fold.t -> ('a, 'r) Fold.t } *)

(* let id : ('a, 'a) t = { t = fun x -> x } *)

(* let ( >>> ) (t1 : ('a, 'x) t) (t2 : ('x, 'b) t) : ('a, 'b) t = *)
(*   let { t = t1_ } = t1 in *)
(*   let { t = t2_ } = t2 in *)
(*   { t = fun z -> t2_ (t1_ z) } *)

(* let map (f : 'a -> 'b) : ('a, 'b) t = *)
(*   let open Fold in *)
(*   let go = fun { step; this; proj } -> *)
(*     let step = fun a s -> step (f a) s in *)
(*     { step; this; proj } *)
(*   in { t = go } *)

(* let flatMap (f : 'a -> 'b Stream.t) *)
