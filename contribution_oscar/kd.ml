type data = float array;;

type node = 
|vide
|node of data*node*node;;

type arbre_K_d={
dimension : int;
racine : node;
};;

type 'label t = arbre_K_d;;

let rec debut (l : 'a list )(i :int) : 'a list = 
 match i with
  |0 -> l
  |_-> hd.l :: debut (l , i-1);;

let fin (l : 'a list )(i :int) : 'a list = 
let new_list = List.rev l in
let a = List.length l in
let res = debut (new_list , (a-i)) in
res ;;


let mediancoord (donne : data list) (i: int) :(data * data list * data list) =
 let a = List.length in
 let comparaison ( a : data ) (b : data ) : int =
	if ( a.(i) < b.(i) ) then 
	 -1
	else if ( a.(i) = b.(i) ) then 
	 0
	 else 1
 in
 let new_list = List.sort ( donne , comparaison) in
 let median_p = nth ( newlist , (a/2)-1) in 
 let median_i = nth ( newlist , (a/2)) in
 if ( a%2 = 0 ) then 
  let res = ( median_p , debut ( new_list , (a/2)-2) , fin (new_list , (a/2)) )in
 else
  let res = ( median_i , debut (new_list , (a/2)-1) , fin (new_list , (a/2)+1 ) in
 res ;;


let init (seq : (data * 'label) Seq.t) : 'label t =
  

let classify (seq : 'label t) (k : int) (x : data) : 'label =
  

