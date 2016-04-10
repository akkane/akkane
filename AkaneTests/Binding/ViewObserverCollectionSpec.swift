//
// This file is part of Akane
//
// Created by JC on 02/12/15.
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code
//

import Foundation
import Quick
import Nimble
import Bond
@testable import Akane

class ViewObserverCollectionSpec : QuickSpec {
    override func spec() {
        var collection: ViewObserverCollection!
        var view: ViewStub!
        var lifecycle: LifecycleMock!

        beforeEach {
            view = ViewStub()
            lifecycle = LifecycleMock()
            collection = ViewObserverCollection(view: view, lifecycle: lifecycle)
        }

        describe("observe") {
            context("when observing Observable") {
                it("should save observation") {
                    let observable = Observable("hello")
                    collection.observe(observable)

                    expect(collection.count) == 1
                }
            }

            context("when observing Command") {
                it("should NOT save observation") {
                    collection.observe(RelayCommand() { _ in })

                    expect(collection.count) == 0
                }
            }

            context("when observing observable view model") {
                var viewModel: ViewModelMock!

                beforeEach {
                    viewModel = ViewModelMock()

                    lifecycle.presenterToReturn = ComponentViewController.init(view: view.viewToBind)
                }

                it("should bind view with viewmodel") {
                    collection.observe(viewModel).bindTo(view.viewToBind)

                    expect(lifecycle.presenterToReturn!.viewModel as? ViewModelMock) === viewModel
                }

                it("should NOT save observation") {
                    collection.observe(viewModel)

                    expect(collection.count) == 0
                }
            }
        }

        describe("unobserve") {
            beforeEach {
                collection.observe(Observable("Should Be Disposed"))
            }

            it("should unobserve bindings") {
                collection.unobserve()
                expect(collection.count) == 0
            }
        }
    }

    class ViewStub : UIView, ComponentView {
        var viewToBind: ViewMock

        override init(frame: CGRect) {
            self.viewToBind = ViewMock()


            super.init(frame: frame)

            self.addSubview(self.viewToBind)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func bindings(observer: ViewObserver, viewModel: AnyObject) {

        }
    }

    class ViewMock : UIView, ComponentView {
        func bindings(observer: ViewObserver, viewModel: AnyObject) {

        }
    }

    class LifecycleMock : Lifecycle {
        var presenterToReturn: ComponentViewController? = nil

        func presenterForSubview<T:UIView where T:ComponentView>(subview: T, createIfNeeded: Bool) -> ComponentViewController?  {
            return self.presenterToReturn
        }
    }

    class ViewModelMock : ComponentViewModel {

    }
}
