type 'a t = { head : 'a; tail : 'a t Lazy.t }
            
let head x = x.head
let tail x = Lazy.force x.tail
let uncons { head; tail } = Some (head, Lazy.force tail)
let cons head tail_ = let tail = lazy tail_ in { head; tail }
                        
let rec map f { head; tail } =
  { head = f head; tail = lazy (map f (Lazy.force tail)) }

let rec pure head = { head; tail = lazy (pure head) }

let rec ap fs xs =
  let head = fs.head xs.head in
  let tail = lazy (ap (Lazy.force fs.tail) (Lazy.force xs.tail)) in
  { head; tail }
  
let rec zip_with f xs ys =
  let (<*>) = ap in
  (pure f <*> xs) <*> ys

let rec unzip_with f { head; tail } =
  let (l, r) = f head in
  let tail_ = lazy (unzip_with f (Lazy.force tail)) in
  let ls = { head = l; tail = lazy (fst (Lazy.force tail_)) } in
  let rs = { head = r; tail = lazy (snd (Lazy.force tail_)) } in
  ( ls, rs )
  
let rec fold phi { head; tail } =
  phi head (lazy (fold phi (Lazy.force tail)))

let rec unfold phi seed =
  let (head, seed') = phi seed in
  { head; tail = lazy (unfold phi seed') }
  
let ints =
  let rec go head =
    let tail = lazy (go (head+1)) in { head; tail }
  in go 0

let rec iterate f head = { head; tail = lazy (iterate f (f head)) }
let tabulate f = map f ints

let rec take n { head; tail } =
  if n <= 0
  then []
  else head :: take (n-1) (Lazy.force tail)

let rec take_while pred { head; tail } =
  if pred head
  then head :: take_while pred (Lazy.force tail)
  else []
  
let rec drop n ({ head; tail } as s) =
  if n <= 0
  then s
  else drop (n-1) (Lazy.force tail)

let rec drop_while pred { head; tail } =
  if pred head
  then drop_while pred (Lazy.force tail)
  else tail

let rec filter pred { head; tail } =
  let tail = lazy (filter pred (Lazy.force tail)) in
  if pred head
  then { head; tail }
  else Lazy.force tail

let rec at n { head; tail } =
  if n <= 0 then head else at (n-1) (Lazy.force tail)
  
let inits s = zip_with take ints (pure s)
let tails s = zip_with drop ints (pure s)

let rec interleave xs ys =
  let tail2 = lazy (interleave (Lazy.force ys.tail) (Lazy.force xs.tail)) in
  let tail1 = lazy { head = ys.head; tail = tail2 } in
  { head = xs.head; tail = tail1 }

let extract x = x.head
let extend f s = map f (tails s)
