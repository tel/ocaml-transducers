
type ('a, 'b) t = { t : 'r . ('b, 'r) Moore.t -> ('a, 'r) Moore.t }

let id = { t = fun x -> x }
let compose { t = t1 } { t = t2 } = { t = fun z -> t1 (t2 z) }

let dimap f g { t = t } = { t = fun z -> Moore.lmap f (t (Moore.lmap g z)) }
let lmap f = dimap f (fun x -> x)
let rmap f = dimap (fun x -> x) f
let map f  = rmap f
let arr f  = { t = fun z -> Moore.lmap f z }
