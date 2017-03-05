require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
let(:valid_attributes) { {
   title: RandomData.random_sentence,
   body: RandomData.random_paragraph,
   resolved: RandomData.random_boolean
 } }

  let(:question) { Question.create!(valid_attributes) }

  describe "GET #index" do
    it "assigns all questions as @questions" do
      get :index
      expect(assigns(:questions)).to eq([question])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: question.id}
      expect(response).to have_http_status(200)
    end

    it "assigns the requested question as @question" do
      get :show, {id: question.id}
      expect(assigns(:question)).to eq(question)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(200)
    end

    it "assigns a new question as @question" do
      get :new
      expect(assigns(:question)).to be_a_new(Question)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: question.id}
      expect(response).to have_http_status(200)
    end

    it "renders the #edit view" do
      get :edit, {id: question.id}
      expect(response).to render_template :edit
    end

    it "assigns post to be updated to @post" do
      get :edit, {id: question.id}
      question_instance = assigns(:question)

      expect(question_instance.id).to eq question.id
      expect(question_instance.title).to eq question.title
      expect(question_instance.body).to eq question.body
    end
  end

# Ask Shannon about testing for valid / invalid params
  describe "POST #create" do
    it "creates a new Question" do
      expect {
        post :create, question: valid_attributes
      }.to change(Question, :count).by(1)
    end

    it "assigns a newly created question as @question" do
      post :create, question: valid_attributes
      expect(assigns(:question)).to be_a(Question)
      expect(assigns(:question)).to be_persisted
    end

    it "redirects to the created question" do
      post :create, question: valid_attributes
      expect(response).to redirect_to(Question.last)
    end
  end

  describe "PUT #update" do
    # context "with valid params" do
      # let(:new_attributes) {
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_resolved_answer = RandomData.random_boolean
      # }

      it "updates the requested question" do
        put :update, id: question.id, question: {title: new_title, body: new_body, resolved: new_resolved_answer}
        question.reload

        updated_question = assigns(:question)
        expect(updated_question.id).to eq(question.id)
        expect(updated_question.title).to eq(new_title)
        expect(updated_question.body).to eq(new_body)
        expect(updated_question.resolved).to eq(new_resolved_answer)
      end

      it "assigns the requested question as @question" do
        question = Question.create! valid_attributes
        put :update, id: question.id, question: valid_attributes
        expect(assigns(:question)).to eq(question)
      end

      it "redirects to the question" do
        question = Question.create! valid_attributes
        put :update, id: question.id, question: valid_attributes
        expect(response).to redirect_to(question)
      end
    # end

    # context "with invalid params" do
    #   it "assigns the question as @question" do
    #     question = Question.create! valid_attributes
    #     put :update, params: {id: question.to_param, question: invalid_attributes}, session: valid_session
    #     expect(assigns(:question)).to eq(question)
    #   end
    #
    #   it "re-renders the 'edit' template" do
    #     question = Question.create! valid_attributes
    #     put :update, params: {id: question.to_param, question: invalid_attributes}, session: valid_session
    #     expect(response).to render_template("edit")
    #   end
    # end
  end

  describe "DELETE #destroy" do
    it "destroys the requested question" do
      question = Question.create! valid_attributes
      expect {
        delete :destroy, id: question.id
      }.to change(Question, :count).by(-1)
    end

    it "redirects to the questions list" do
      question = Question.create! valid_attributes
      delete :destroy, id: question.id
      expect(response).to redirect_to(questions_url)
    end
  end

end
