(** Type des données à classer *)
type data = float array

(** Type interne à ce module pour représenter ses données d'entrainement.
    Dans la partie sans prétraitement, on choisit simplement la séquence des
    couples (donnée, étiquette).
    Dans la partie avec arbre k-d, ce sera un arbre dimensionnel. *)
type 'label t

val count_item : 'a Seq.t -> 'a -> int
val most_frequent : 'a list -> 'a
val euclidean_dist : data -> data-> float
val sgn : float -> int;;

val mnist_seq : int -> Mnist.idx -> Mnist.idx -> int t

(** Initialisation des données d'entrainement *)
val init : (data* 'label) Seq.t -> 'label t

(** Classification d'une donnée *)
val classify : 'label t -> int -> data -> 'label

(** Statistique *)
(* trainSize -> testSize -> trainImg -> testImg -> trainLabel -> testLabel -> k -> success_rate_in_percent*)
val error_rate : int -> int -> Mnist.idx -> Mnist.idx -> Mnist.idx -> Mnist.idx -> int -> float