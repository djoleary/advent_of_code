module ID : sig
  (** [t] is a ID within a range *)
  type t

  val create : int -> t
  (** [create num] is an ID [t] *)

  val incr : t -> t
  (** [incr id] is the next [id] in the sequence *)

  val to_string : t -> string
  (** [to_string id] is an string representation of [id] *)

  val pp : t -> string
  (** [pp id] is a pretty string representing [id] *)
end

module Range : sig
  (** [t] is a range of values *)
  type t

  val create : int * int -> t
  (** [create (s, e)] is a range starting at [s] and ending at [e]. *)

  val collect : t -> ID.t list
  (** [collect r] is a list containing all elements within the range (inclusive). *)

  val pp : t -> string
  (** [pp r] is a pretty string representing [r] *)
end
