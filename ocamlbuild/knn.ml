
let rec count_item (s: 'a Seq.t) (e: 'a) : int = 
  Seq.fold_left (fun a b -> if b = e then a + 1 else a) 0 s;;

let most_frequent (s: 'a list) : 'a = 
  snd (List.hd (List.fast_sort (fun x y -> fst x - fst y) (List.map (fun a -> (List.fold_left (fun c d -> if d = a then c+1 else c) 0 s ,a)) s)));;

let euclidean_dist (a: int array) (b: int array) : float = 
  float_of_int (Array.fold_left (+) 0 (Array.map2 (fun x y -> (x - y) * (x - y)) a b));;

let old_euclidean_dist (a: int array) (b: int array) : float = 
  sqrt (float_of_int (Array.fold_left (+) 0 (Array.map2 (fun x y -> (x - y) * (x - y)) a b)));;
  
let python_range (a: int) (b: int) : int Seq.t = 
  let rec aux (i: int) : int Seq.t = 
    if i < b then
      fun _ -> Seq.Cons (i, aux (i + 1))
    else
      fun _ -> Seq.Nil in
  aux a;;
    
let mnist_seq (n: int) (img: Mnist.idx) (labels: Mnist.idx) : (int array * int) Seq.t =
  let rec aux (i: int) : (int array * int) Seq.t = 
    if i < n then
      fun _ -> Seq.Cons ((Mnist.get img i, (Mnist.get labels i).(0)), aux (i+1))
    else 
      fun _ -> Seq.Nil in
  aux 0;;

let init (seq : (int array * 'label) Seq.t) : (int array * 'label) Seq.t = 
  seq;;

let sgn (f: float) : int = if f > 0. then 1 else -1;;

let seq_iteri f seq =
  let rec aux seq i = match seq () with
    | Seq.Nil -> ()
    | Seq.Cons (x, next) ->
        f i x;
        aux next (i + 1)
  in
  aux seq 0;;

let classify (k: int) (s: (int array * 'label) Seq.t) (aa: int array) : 'label =
  let f = ref (PrioQueue.create (fun (x: (int array * 'label)) (y: (int array * 'label)) -> sgn (euclidean_dist aa (fst x) -. euclidean_dist aa (fst y)))) in
  seq_iteri (fun i a -> 
    if i < k then (
      f := PrioQueue.insert !f a
    )
    else
      (
        if euclidean_dist aa (fst a) < euclidean_dist aa (fst (PrioQueue.top !f)) then
          (
            f := PrioQueue.change_root !f a
          )
      )
    ) s;
  snd (most_frequent ( PrioQueue.to_unsorted_list !f));;
  