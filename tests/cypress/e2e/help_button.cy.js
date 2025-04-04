// tests/cypress/e2e/message.cy.js

describe("Help button", () => {
    beforeEach(() => {
        cy.visit("/");
    });
    it("'Help' button exists", () => {
        cy.get(".help button")
    });

    it("'Help' button shows the message", () => {
        cy.get(".help button").click();
        const stub = cy.stub()
        cy.on ('window:alert', stub)
        cy
        .then(() => {
            expect(stub.getCall(0)).to.be.calledWith('Learn more about Rhino: https://appsilon.github.io/rhino/')
        })
    });
  });