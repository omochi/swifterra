import XCTest
import Swifterra

final class swifterraTests: XCTestCase {
    func testRender() throws {
        let tf = TFFile("main.tf") {
            Resource("aws_foo", "this") {
                A("int", 12)
                A("double", 3.14)
                A("string", "hello")
                A("symbol", Symbol("aws_foo.this.id"))
                A("array", ArrayValue {
                    1
                    "str"
                    Symbol("foo")
                })
                A("object", ObjectValue {
                    A("a", 1)
                    A("b", "str")
                    A("c", ArrayValue {
                        2
                        3
                    })
                })
                Block("foo", "a", "b") {
                    A("a", 1)
                }
                A("fc", FunctionCall("f", 1, 2))
            }
            DataSource("aws_bar", "this") {
                A("a", 1)
                A("b", 2)
            }
        }

        XCTAssertEqual(try tf.render(), """
        resource "aws_foo" "this" {
          int = 12
          double = 3.14
          string = "hello"
          symbol = aws_foo.this.id
          array = [
            1,
            "str",
            foo
          ]
          object = {
            a = 1
            b = "str"
            c = [
              2,
              3
            ]
          }
          foo "a" "b" {
            a = 1
          }
          fc = f(
            1,
            2
          )
        }

        data "aws_bar" "this" {
          a = 1
          b = 2
        }

        """)
    }
}
