type Props = {
    selectedPrice?: number;
    onChange: (value?: number) => void;
  };
  
  const PriceFilter = ({ selectedPrice, onChange }: Props) => {
    return (
      <div>
        <h4 className="text-md font-semibold mb-2"> Max Price</h4>
        <select 
          aria-label="State"
          className="p-2 border rounded-md w-full"
          value={selectedPrice}
          onChange={(event) =>
            onChange(
              event.target.value ? parseInt(event.target.value) : undefined
            )
          }
        >
          <option value="">Select Max Price</option>
          {[2000, 4000, 6000, 8000, 12000].map((price) => (
            <option value={price}>{price}</option>
          ))}
        </select>
      </div>
    );
  };
  
  export default PriceFilter;