Rails.application.routes.draw do
  get 'all'            => 'outlines#index', as: :outlines
  get 'outlines/:date' => 'outlines#show',  as: :outline
  root 'outlines#today'
end
