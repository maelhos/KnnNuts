let python_range (a: int) (b: int) : int Seq.t = 
  let rec aux (i: int) : int Seq.t = 
    if i < b then
      fun _ -> Seq.Cons (i, aux (i + 1))
    else
      fun _ -> Seq.Nil in
  aux a;;

let seventeenFortyTwo = 
  let rec aux (b: bool) : int Seq.t =
    if b then
      fun _ -> Seq.Cons (17, aux (not b))
    else
      fun _ -> Seq.Cons (42, aux (not b))
    in aux true;;

let integers =
  let rec r (a: int) : int Seq.t = 
    fun _ -> Seq.Cons (a, r (a + 1))
  in r 0;;