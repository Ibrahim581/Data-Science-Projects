import streamlit as st
import pdfplumber as pd
from transformers import pipeline
# from transformers import T5Tokenizer, T5ForConditionalGeneration

# Initializing LLM
qa_pipeline = pipeline("question-answering", model="deepset/roberta-base-squad2")



# Extracting text
def extract_text(pdf):
    text = ''
    with pd.open(pdf) as pdf:
        for page in pdf.pages:
            text += page.extract_text() or ''
    return text    
    
# LLM analyzing text
def analyze_text(text, question):
    output = qa_pipeline(question = question, context = text)
    return output['answer']  

    
    
def main():
    st.header('Chat with DocGPT')
    st.write('By Ibrahim Noman')

    # Pdf uploader
    pdf = st.file_uploader('Upload PDF', type = 'pdf')
    if pdf is not None:
        text = extract_text(pdf)
            
        # User Input    
        question = st.text_input('Chat with DocGPT')    
        if st.button('Get Answer'):
            if question is not None:
                answer = analyze_text(text, question)
                st.write('Answer:') 
                st.success(answer)
            else:
                st.error('Please enter a question')   
    
if __name__ == '__main__':
    main()  
    
    
    
                                  