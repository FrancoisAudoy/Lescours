(* verifiez que votre fichier d'initialisation d'emacs 
  contient la ligne
(load-file "/usr/share/emacs/site-lisp/proofgeneral/generic/proof-site.el")
 *)


(** premiers pas en Coq *)

Section Declarations.

  Variables P Q R S T : Prop.

  Lemma imp_dist: (P -> Q -> R) -> (P -> Q) -> P -> R.
  Proof.
    intro H.
    intro H0.
    intro H1.
    apply H.
    assumption.
    apply H0.
    assumption.
  Qed.

  (* exemple de preuve d'un sequent *)

  Section S1.
    Hypothesis H : P -> Q.
    Hypothesis H0 : P -> Q -> R.

    Lemma L2 : P -> R.
    Proof.
      intro p.
      apply H0.
      assumption.
      apply H.
      assumption.
    Qed.

  End S1.

  Section About_cuts.
    Hypothesis H : P -> Q.
    Hypothesis H0 : P -> Q -> R.
    Hypothesis H1 : Q -> R -> S.
    Hypothesis H2 : Q -> R -> S -> T.

    (* preuve sans lemme (coupure) *)
    Lemma L3 : P -> T.
    Proof.
      intro p.
      apply H2.
      apply H.
      assumption.
      apply H0.
      assumption.
      apply H; assumption.
      apply H1.
      apply H; assumption.
      apply H0.
      assumption.
      apply H;assumption.
    Qed.

    (* preuve avec coupures *)

     Lemma L'3 : P -> T.
       intro p.
       assert (q: Q).  {
         apply H; assumption.
        }
       assert (r: R). {
         apply H0; assumption.
       }
       assert (s : S). {
        apply H1; assumption.
       }
       apply H2; assumption.
     Qed.

  End About_cuts.


 (* Exercices 

    Reprendre les exemples vus en TD, en utilisant les tactiques 
    assumption, apply et intros

    Remplacer la commande Admitted par une preuve correcte suivie de la
    commande Qed.

  *)

  Lemma IdP : P -> P.
  Proof.
    intro H.
    assumption.
    Qed.
  Section s1.
    Hypothesis H: P.
    End s1.



  Lemma IdPP : (P -> P) -> P -> P.
  Proof.
    intro H0.
    assumption.
  Qed.

  Section A.
    Hypothesis H0: P.
    End A.
  
  
  Lemma imp_trans : (P -> Q) -> (Q -> R) -> P -> R.
  Proof.
    intro H.
    intro H0.
    intro H1.
    apply H0.
    apply H.
    assumption.
    Qed.
     
      Section B.
      Hypothesis H: P -> Q.
      Hypothesis H0: Q -> R.
      Hypothesis H1: P.

    End B.


  Section proof_of_hyp_switch.
    Hypothesis H : P -> Q -> R.
    Lemma hyp_switch : Q -> P -> R.
    Proof.
      intro H0.
      intro H1.
      apply H.
      assumption.
      assumption.
      Qed.
      

      Hypothesis H0: Q.
      Hypothesis H1: P.

  End proof_of_hyp_switch.

  Check hyp_switch.

  Section proof_of_add_hypothesis.
    Hypothesis H : P -> R.

    Lemma add_hypothesis : P -> Q -> R.
    Proof.
      intro H0.
      intro H1.
      apply H.
      assumption.
    Qed.
    
      Hypothesis H0: P.
      Hypothesis H1: Q.

  End proof_of_add_hypothesis.

  (* prouver le sequent (P -> P -> Q) |- P -> Q  *)
  Section Proof_Pas_de_nom.
    Hypothesis H:P-> P-> Q.
    Lemma Pas_de_nom : P->Q.
    Proof.
      intro H0.
      apply H.
      assumption.
      assumption.
    Qed.
      Hypothesis H0: P.
  End Proof_Pas_de_nom.
  (* meme exercice avec 
     P -> Q , P -> R , Q -> R -> T |- P -> T  
   *)
  Section proof_Meme_nom_dessus.
    Hypothesis H: P->Q.
    Hypothesis H0: P->R.
    Hypothesis H1: Q->R->T.
    Lemma Meme_nom_dessus: P-> T.
      intro H2.
      apply H1.
      apply H.
      assumption.
      apply H0.
      assumption.
      Qed.

  
    
    End proof_Meme_nom_dessus.

  Lemma weak_Peirce : ((((P -> Q) -> P)-> P) -> Q) -> Q.
  Proof.
    intro H.
    apply H.
    intro H1.
    apply H1.
    intro H2.
    apply H.
    intro H3.
    assumption.
    Qed.
  (* S'il reste du temps : tacticielle ; 
                           tac ; trivial
                           auto.
     contradiction et negation

   *)
  
     