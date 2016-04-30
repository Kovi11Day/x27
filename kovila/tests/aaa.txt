mk_tree("div", false, false, false,
        mk_forest(mk_tree("a",false,false,false,mk_forest(false, mk_word("a"), mk_forest(false,mk_word("b"),NULL))),
                  mk_forest(false,mk_word("a"),
                            mk_forest(false,mk_tree("b",false,false,false,NULL),mk_forest(false,mk_word("a"),NULL),
                                      mk_forest(false,mk_word("a"), mk_forest(false,mk_word("b"),mk_forest(false,mk_word("b")))))
                            )
                  )
      )
