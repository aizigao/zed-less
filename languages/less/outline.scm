;; Less outline
;; === Comments as annotations (optional)
(comment) @annotation
(js_comment) @annotation

;; ===  base cass
(stylesheet
    (import_statement
        "@import" @context
        ((string_value) @name)) @item)

(rule_set
    (selectors
      .
      (_) @name
      ("," @name (_) @name)*
    )) @item

(media_statement
    "@media" @context
    (_) @name
    (block)
) @item

;; === Rulesets: .a, #b { ... } (supports nested selectors)
(rule_set
  (selectors
    (class_selector (class_name) @name)
    (id_selector (id_name) @name)
    (descendant_selector
      (class_selector (class_name) @name)
      (id_selector (id_name) @name)
    )*
  )
) @item

;; === Supports queries: @supports ... { ... }
(supports_statement
  "@supports" @context
  (feature_query (feature_name) @name (plain_value) @context)
  (block)
) @item

;; === Keyframes: @keyframes spin { ... }
(keyframes_statement
  "@keyframes" @context
  (keyframes_name) @name
  (keyframe_block_list)
) @item

;; === Mixin definitions: .mixin(...) { ... }
(mixin_definition
  (class_name) @name
  (parameters) @context
) @item

;; === Plugin statements: @plugin "xxx" / @plugin grid
(plugin_statement
  "@plugin" @context
  (string_value) @name
) @item

;; === Each statements: each(@colors, { ... })
(each_statement
  "each" @context
  (variable) @name
  (block)
) @item

;; 9. Variable declarations: @var: value;
(declaration
  (property_name) @name
  ; _ @context
  (#match? @name "^@|^--")
) @item
