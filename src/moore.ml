
type ('a, 'b, 's) spec =
  { step : 'a -> 's -> 's
  ; this : 's
  ; proj : 's -> 'b
  }

type (_,_) t = T : ('a, 'b, 's) spec -> ('a, 'b) t

let make spec = T spec
let run (T {step; this; proj}) = fun a ->
  let this = step a this in
  ( proj this, T { step; this; proj } )

type ('a, 'b) either = [ `Inl of 'a | `Inr of 'b ]

let dimap f g (T { step; this; proj }) =
  let step = fun a s -> step (f a) s in
  let proj = fun s -> g (proj s) in
  T { step; this; proj }

let lmap f = dimap f (fun x -> x)
let rmap g = dimap (fun x -> x) g

let pure a =
  let step = fun _ s -> s in
  let this = () in
  let proj = fun _ -> a in
  T { step; this; proj }

let ap (T fm) (T xm) =
  let step = fun e (fs, xs) -> (fm.step e fs, xm.step e xs) in
  let this = (fm.this, xm.this) in
  let proj = fun (fs, xs) -> (fm.proj fs) (xm.proj xs) in
  T { step; this; proj }

let extract (T m) = m.proj m.this

let extend phi (T { step; this; proj }) =
  T { step; this; proj = fun this -> phi (T {step; this; proj}) }

