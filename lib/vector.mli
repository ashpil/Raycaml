(** [t] is the vector type *)
type t

(** [from_json j] is the vector represented by the json structure [j] *)
val from_json : Yojson.Basic.t -> t

(** [create x y z] is the vector with coordinates [x], [y], and [z] *)
val create : float -> float -> float -> t 

(** [origin] is the vector with coordinates [0], [0], and [0] *)
val origin : t 

(** [get_x v] is the x coordinate of vector [v] *)
val get_x : t -> float 

(** [get_y v] is the y coordinate of vector [v] *)
val get_y : t -> float 

(** [get_z v] is the z coordinate of vector [v] *)
val get_z : t -> float

(** [ minus v1 v2] is the vector difference of vector [v1] minus vector [v2]. *)
val minus : t -> t -> t

(** [ add v1 v2] is the vector sum of vector [v1] plus vector [v2]. *)
val add : t -> t -> t 

(** [ mult v1 v2] is the vector product of vector [v1] and vector [v2]. *)
val mult : t -> t -> t

(** [div_constant v c] is a vector after each coordinate has been divided by a 
    constant factor c *)
val div_constant : t -> float -> t 

(** [ mult_constant v c] is a vector after each coordinate has been 
    multiplied by a constant factor c *)
val mult_constant : t -> float -> t 

(** [dot_prod v1 v2] is the dot product of the vectors [v1] and [v2]*)
val dot_prod : t -> t -> float 

(** [cross_produ v1 v2] is the cross product of the vectors [v1] and [v2]*)
val cross_prod : t -> t -> t 

(** [length v] is the length, or norm, of [v] *)
val length : t -> float 

(** [unit_vector v] is the unit vector (vector with magnitude 1
    and direction) of [v] *)
val unit_vector : t -> t

(** [det v1 v2 v3] is the determinant of the matrix that has [v1 v2 v3] as its
    columns *)
val det : t -> t -> t -> float

(** [string_of_vector v] is the string "[ x y z ]" when [v] has x coordinate x,
    y coordinate y, and z coordinate z *)
val string_of_vector : t -> string
