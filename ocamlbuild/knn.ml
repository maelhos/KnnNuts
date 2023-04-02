type data = float array
type 'label t = (data * 'label) Seq.t

let rec count_item (s: 'a Seq.t) (e: 'a) : int = 
  Seq.fold_left (fun a b -> if b = e then a + 1 else a) 0 s;;

let most_frequent (s: 'a list) : 'a = 
  snd (List.hd (List.fast_sort (fun x y -> fst x - fst y) (List.map (fun a -> (List.fold_left (fun c d -> if d = a then c+1 else c) 0 s ,a)) s)));;

let euclidean_dist (a: data) (b: data) : float = 
  sqrt (Array.fold_left (+.) 0. (Array.map2 (fun x y -> (x -. y) *. (x -. y)) a b));;
  
let python_range (a: int) (b: int) : int Seq.t = 
  let rec aux (i: int) : int Seq.t = 
    if i < b then
      fun _ -> Seq.Cons (i, aux (i + 1))
    else
      fun _ -> Seq.Nil in
  aux a;;
    
let mnist_seq (n: int) (img: Mnist.idx) (labels: Mnist.idx) : int t =
  let rec aux (i: int) : (data * int) Seq.t = 
    if i < n then
      fun _ -> Seq.Cons ((Array.map float_of_int (Mnist.get img i), (Mnist.get labels i).(0)), aux (i+1))
    else 
      fun _ -> Seq.Nil in
  aux 0;;

let init (seq : (data * 'label) Seq.t) : 'label t = 
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

let classify (seq: 'label t) (k: int) (aa: data) : 'label =
  let f = ref (PrioQueue.create (fun (x: (data * 'label)) (y: (data * 'label)) -> sgn (euclidean_dist aa (fst x) -. euclidean_dist aa (fst y)))) in
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
    ) seq;
  snd (most_frequent ( PrioQueue.to_unsorted_list !f));;
  
let error_rate (trainSize: int) (testSize: int) (trainImg: Mnist.idx) (testImg: Mnist.idx) 
    (trainLabel: Mnist.idx) (testLabel: Mnist.idx) (k: int) : float =
  let se = mnist_seq trainSize trainImg trainLabel in
  let a = ref 0 in
  for l = 0 to testSize - 1 do
  if classify se 3 (Array.map float_of_int (Mnist.get testImg l)) = (Mnist.get testLabel l).(0) then
    a := !a + 1
  done;
  100. *. (float_of_int !a) /. float_of_int testSize;;