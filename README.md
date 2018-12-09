# pca_picker
A picker view of province-city-area three-level linkage.

#### How to use it?

* Init the picker view.

* Call the method `show()`.eg.`picker.show()`.

* The picker result is a Tuple will callback from the `SelectValueCallback` of picker view instance.

  such as:

  ```swift
  picker.selectValue = { (p, c, a) in
              self.resultLabel.text = p + c + a
          }
  ```


